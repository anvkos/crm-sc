<template lang="pug">
  div.q-pa-md
    QTable(
      title="Organizations"
      :data="items"
      :columns="columns"
      row-key="id"
      :pagination.sync="pagination"
      selection="multiple"
      :selected.sync="selected"
      :selected-rows-label="selectedLabel"
    )
      template(v-if="selected.length > 0" v-slot:bottom-row)
        QTr
          QTd(colspan="100%" class="q-pa-md q-gutter-sm")
            QBtn(label="Delete" size="sm" @click="onDelete")
            div.float-right {{ selectedNames }}

</template>

<script>
import { QTable, QBtn, QTr, QTd } from 'quasar';

export default {
  components: {
    QTable,
    QBtn,
    QTr,
    QTd,
  },

  props: {
    items: Array,
    default: [],
  },

  data() {
    return {
      selected: [],
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
    selectedNames() {
      return this.selected.map(item => item.name).join(', ');
    },
  },

  methods: {
    selectedLabel() {
      const length = this.selected.length;
      return length === 0 ? '' : `${length} record${length > 1 ? 's' : ''} selected of ${this.items.length}`;
    },

    onDelete() {
      this.$emit('organizations-deleted', this.selected.map(item => item.id));
    },
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
