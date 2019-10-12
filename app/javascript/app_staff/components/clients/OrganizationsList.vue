<template lang="pug">
  div.q-pa-md
    q-table(
      title="Organizations"
      :data="items"
      :columns="columns"
      row-key="id"
    )
</template>

<script>
import { QTable } from 'quasar';

export default {
  components: {
    QTable,
  },

  props: {
    items: Array,
    default: [],
  },

  data() {
    return {
      columns: [
        { name: 'id', label: '#',field: 'id', align: 'left', },
        { name: 'name', label: 'Name',field: 'name', sortable: true, },
        { name: 'kind', label: 'Type',field: 'kind', },
        { name: 'inn', label: 'INN',field: 'inn', },
        { name: 'ogrn', label: 'OGRN',field: 'ogrn', },
      ],
      pagination: {
        rowsPerPage: 20,
      },
    };
  },

  computed: {
  },

  methods: {
  },
};
</script>

<style lang="scss" scoped>
  .q-table {
    th:first-child,
    td:first-child {
      width: 50px;
    }
    span {
      line-height: 50px;
    }
  }
</style>
