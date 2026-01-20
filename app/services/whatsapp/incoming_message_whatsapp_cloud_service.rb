# https://docs.360dialog.com/whatsapp-api/whatsapp-api/media
# https://developers.facebook.com/docs/whatsapp/api/media/

class Whatsapp::IncomingMessageWhatsappCloudService < Whatsapp::IncomingMessageBaseService
  private

  def processed_params
    @processed_params ||= params[:entry].try(:first).try(:[], 'changes').try(:first).try(:[], 'value')
  end

  def download_attachment_file(attachment_payload)
    media_url = inbox.channel.media_url(
      attachment_payload[:id],
      inbox.channel.provider_config['phone_number_id']
    )
    Rails.logger.info "[WHATSAPP] Fetching media URL: #{media_url}"

    url_response = HTTParty.get(media_url, headers: inbox.channel.api_headers)

    Rails.logger.info "[WHATSAPP] Media URL response status: #{url_response.code}"

    if url_response.unauthorized?
      Rails.logger.error "[WHATSAPP] Authorization error fetching media URL"
      inbox.channel.authorization_error!
      return nil
    end

    unless url_response.success?
      Rails.logger.error "[WHATSAPP] Failed to fetch media URL: #{url_response.body}"
      return nil
    end

    download_url = url_response.parsed_response['url']
    Rails.logger.info "[WHATSAPP] Downloading attachment from: #{download_url}"

    # WhatsApp Cloud media URLs require the Authorization header for download
    Down.download(download_url, headers: { 'Authorization' => "Bearer #{inbox.channel.provider_config['api_key']}" })
  rescue StandardError => e
    Rails.logger.error "[WHATSAPP] Error downloading attachment: #{e.message}"
    nil
  end
end
