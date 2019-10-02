<template lang="pug">
  QDialog(v-model="show" @hide="onClose")
    QCard
      QCardSection.row.items-center
        div.text-h6 {{ title }}
        QSpace
        QBtn(icon="fas fa-times" flat round dense v-close-popup)
      QCardSection
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
