<template lang="pug">
  QDrawer(
    v-model="visible"
    :width="200"
    :breakpoint="700"
    overlay
    bordered
  )
    QScrollArea(class="fit")
      QList(v-for="(item, index) in menu" :key="index")
        QItem() {{ item.label }}
</template>

<script>
import {
  QScrollArea,
  QList,
  QItem,
} from 'quasar'

export default {
  components: {
    QScrollArea,
    QList,
    QItem,
  },

  props: {
    visible: {
      type: Boolean,
      default: true,
    }
  },

  data() {
    return {
      menu: [
        { label: 'Clients' },
        { label: 'Organizations' },
      ]
    };
  },
};
</script>
