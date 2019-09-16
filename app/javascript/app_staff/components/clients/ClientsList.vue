<template lang="pug">
  div.table-responsive
    table.table.table-hover
      caption List of clients
      thead
        tr
          th #
          th Full name
          th Phone
          th Email
      tbody
        tr(v-for="client in clients" :key="client.id")
          td {{ client.id }}
          td {{ client.fullname }}
          td {{ client.phone }}
          td {{ client.email }}

</template>

<script>
export default {
  props: {
    clients: {
      type: Array,
      required: true,
    }
  },

  data() {
    return {};
  },
};
</script>

<style lang="scss" scoped>
  table {
    tr:last-child {
      border-bottom: 1px solid #dee2e6;
    }
  }
</style>
