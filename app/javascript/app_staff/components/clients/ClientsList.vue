<template lang="pug">
  div.q-pa-md
    q-table(
      title="Clients"
      :data="clients"
      :columns="columns"
      row-key="id"
      :pagination.sync="pagination"
    )
      template(v-slot:body-cell-actions="props")
        q-td(:props="props")
          q-btn(label="edit" flat color="green" size="sm" :to="{ name: 'clients.edit', params: { id: props.value } }")
          q-btn(label="organizations" flat color="green" size="sm" :to="{ name: 'clients.organizations', params: { id: props.value } }")
</template>

<script>
import { QTable, QTd } from 'quasar';

export default {
  components: {
    QTable,
    QTd,
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
