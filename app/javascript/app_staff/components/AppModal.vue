<template lang="pug">
  q-dialog(v-model="show" @hide="onClose")
    q-card
      q-card-section.row.items-center
        div.text-h6 {{ title }}
        q-space
        q-btn(icon="fas fa-times" flat round dense v-close-popup)
      q-card-section
        slot
</template>

<script>
import { QCard, QCardSection, QSpace } from 'quasar';

export default {
  components: {
    QCard,
    QCardSection,
    QSpace,
  },

  props: {
    title: {
      type: String,
      default: '',
    },
  },

  data() {
    return {
      show: true,
    };
  },

  methods: {
    onClose() {
      this.$router.go(-1);
    },
  },
};
</script>
