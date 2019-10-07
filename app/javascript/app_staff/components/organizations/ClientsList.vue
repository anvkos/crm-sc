<template lang="pug">
  div.q-pa-md
    QTable(
      title="Clients"
      :data="clients"
      :columns="columns"
      row-key="id"
      :pagination.sync="pagination"
    )
</template>

<script>
import { QTable } from 'quasar';

export default {
  components: {
    QTable,
  },

  props: {
    clients: {
      type: Array,
      required: true,
    }
  },

  data() {
    return {
      columns: [
        { name: 'id', label: '#',field: 'id', align: 'left', sortable: true },
        { name: 'fullname', label: 'Full name',field: 'fullname', sortable: true },
        { name: 'phone', label: 'Phone',field: 'phone', sortable: true },
        { name: 'email', label: 'Email',field: 'email', sortable: true },
        { name: 'actions', label: 'Actions', field: 'id' },
      ],
      pagination: {
        rowsPerPage: 20,
      },
    };
  },
};
</script>

<style lang="scss" scoped>
  table {
    th, td {
      white-space: nowrap;
    }
    tr:last-child {
      border-bottom: 1px solid #dee2e6;
    }
  }
</style>
