<template lang="pug">
  q-drawer(
    v-model="visible"
    :width="200"
    :breakpoint="700"
    elevated
    bordered
  )
    q-scroll-area(class="fit")
      q-list(padding class="text-primary")
        q-item(v-for="(item, index) in menuItems" :key="index" :to="item.route")
          q-item-section {{ item.label }}
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
        { label: 'Equipment', route: { name: 'equipments.index' } },
      ]
    };
  },
};
</script>
