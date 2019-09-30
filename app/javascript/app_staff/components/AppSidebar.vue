<template lang="pug">
  QDrawer(
    v-model="visible"
    :width="200"
    :breakpoint="700"
    elevated
    bordered
  )
    QScrollArea(class="fit")
      QList(padding class="text-primary")
        QItem(v-for="(item, index) in menuItems" :key="index" :to="item.route")
            QItemSection {{ item.label }}
</template>

<script>
import {
  QScrollArea,
  QList,
  QItem,
  QItemSection,
} from 'quasar';

export default {
  components: {
    QScrollArea,
    QList,
    QItem,
    QItemSection,
  },

  props: {
    visible: {
      type: Boolean,
      default: true,
    }
  },

  data() {
    return {
      menuItems: [
        { label: 'Dashboard', route: { name: 'index' } },
        { label: 'Clients', route: { name: 'clients.index' } },
        { label: 'Organizations', route: { name: 'organizations.index' } },
        { label: 'Staffs', route: { name: 'staffs.index' } },
      ]
    };
  },
};
</script>
