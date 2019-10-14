<template lang="pug">
  div.q-pa-md
    q-table(
      title="Organizations"
      :data="items"
      :columns="columns"
      row-key="id"
      :pagination.sync="pagination"
      selection="multiple"
      :selected.sync="selected"
      :selected-rows-label="selectedLabel"
    )
      template(v-slot:body-cell-actions="props")
        q-td(:props="props")
          q-btn(label="edit" flat color="green" size="sm" :to="{ name: 'organizations.edit', params: { id: props.value } }")
          q-btn(label="clients" flat color="blue" size="sm" :to="{ name: 'organizations.clients', params: { id: props.value } }")
      template(v-if="selected.length > 0" v-slot:bottom-row)
        q-tr
          q-td(colspan="100%" class="q-pa-md q-gutter-sm")
            q-btn(label="Delete" size="sm" @click="onDelete")
            div.float-right {{ selectedNames }}

</template>

<script>
import { mapActions } from 'vuex';
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
        { name: 'actions', label: 'Actions', field: 'id' },
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
    ...mapActions({
      destroy: 'organizations/destroy',
    }),

    selectedLabel() {
      const length = this.selected.length;
      return length === 0 ? '' : `${length} record${length > 1 ? 's' : ''} selected of ${this.items.length}`;
    },

    onDelete() {
      this.selected.forEach(item => this.destroy(item));
      this.selected = [];
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
