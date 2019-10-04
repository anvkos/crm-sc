<template lang="pug">
  div.q-pa-md
    QTable(
      title="Equipment"
      :data="items"
      :columns="columns"
      row-key="id"
      :pagination.sync="pagination"
    )
      template(v-slot:body-cell-actions="props")
        QTd(:props="props")
          QBtn(label="edit" flat color="green" size="sm" :to="{ name: 'equipments.edit', params: { id: props.value } }")
</template>

<script>
import { QTable, QTd } from 'quasar';

export default {
  components: {
    QTable,
    QTd,
  },

  props: {
    items: {
      type: Array,
      required: true,
    }
  },

  data() {
    return {
      columns: [
        { name: 'id', label: '#', field: 'id', align: 'left', sortable: true },
        { name: 'name', label: 'Name', field: 'name', sortable: true },
        { name: 'type', label: 'Type', field: 'type_name', sortable: true },
        { name: 'serial_number', label: 'Serial Number', field: 'serial_number', sortable: true },
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
