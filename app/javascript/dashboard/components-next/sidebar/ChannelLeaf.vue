<script setup>
import { computed } from 'vue';
import Icon from 'next/icon/Icon.vue';
import ChannelIcon from 'next/icon/ChannelIcon.vue';

const props = defineProps({
  label: {
    type: String,
    required: true,
  },
  active: {
    type: Boolean,
    default: false,
  },
  inbox: {
    type: Object,
    required: true,
  },
});

const reauthorizationRequired = computed(() => {
  return props.inbox.reauthorization_required;
});

const channelBrandColor = computed(() => {
  const type = props.inbox.channel_type;
  if (
    type === 'Channel::Whatsapp' ||
    (type === 'Channel::TwilioSms' && props.inbox.medium === 'whatsapp')
  ) {
    return 'bg-[#25D366]';
  }
  if (type === 'Channel::FacebookPage') {
    return 'bg-[#0084FF]';
  }
  if (type === 'Channel::Instagram') {
    return 'bg-[#C13584]';
  }
  return null;
});

const circleClass = computed(() => {
  if (channelBrandColor.value) return channelBrandColor.value;
  return props.active ? 'bg-n-solid-blue' : 'bg-n-alpha-2';
});
</script>

<template>
  <span
    class="size-5 grid place-content-center rounded-full"
    :class="circleClass"
  >
    <ChannelIcon
      :inbox="inbox"
      class="size-3"
      :class="{ 'text-white': channelBrandColor }"
    />
  </span>
  <div class="flex-1 truncate min-w-0">{{ label }}</div>
  <div
    v-if="reauthorizationRequired"
    v-tooltip.top-end="$t('SIDEBAR.REAUTHORIZE')"
    class="grid place-content-center size-5 bg-n-ruby-5/60 rounded-full"
  >
    <Icon icon="i-woot-alert" class="size-3 text-n-ruby-9" />
  </div>
</template>
