#!/bin/bash
# Script para actualizar el token de WhatsApp

cat << 'RUBY_SCRIPT' | bin/rails runner -
channel = Channel::Whatsapp.find_by(phone_number: '+5491162099508')

if channel.nil?
  puts "❌ Canal no encontrado"
  puts "Canales disponibles:"
  Channel::Whatsapp.all.each do |c|
    puts "  - #{c.phone_number} (ID: #{c.id})"
  end
  exit 1
end

puts "✅ Canal encontrado: ID #{channel.id}"
puts "Provider: #{channel.provider}"

# Actualizar token
channel.provider_config['api_key'] = 'EAA2HpHIdLxkBQdBjbmgdbd25YM3mAOXay5AUkfSkik97Xf1bFxzZB7CeBjodqB9iChBbvxoXCSxpZALRQMSwcNw2j7bZBLACSnEourWd6K9s5NfkMMUDMWZCGKOBnJ3q7tULo9EQY8f5TDFB9NFtl4vdruqRya8t6APK6CYsI8CcxxWfKqZA8zSYzOBFzpOuAeAZDZD'

if channel.save!
  puts "✅ Token actualizado exitosamente"

  # Validar
  if channel.provider_service.validate_provider_config?
    puts "✅ Configuración válida"

    # Sincronizar templates
    channel.sync_templates
    puts "✅ Templates sincronizados: #{channel.message_templates&.count || 0}"
  else
    puts "❌ Configuración inválida"
  end
end
RUBY_SCRIPT
