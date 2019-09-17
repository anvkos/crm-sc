<template lang="pug">
  div.container
    div.row
      h2 Dashboard
    div.row
      div.col
        ClientsList(:clients="clients")
      div.col
        ClientForm(@client-created="onClientCreated")
</template>

<script>
import ClientsList from './clients/ClientsList';
import ClientForm from './clients/ClientForm';
import Api from '../api';

export default {
  components: {
    ClientsList,
    ClientForm,
  },

  data() {
    return {
      loading: true,
      clients: [],
    };
  },

  created() {
    this.fetchClients();
  },

  methods: {
    fetchClients() {
      this.loading = true;
      Api.clients.fetchAll().then(data => {
        this.clients = data;
        this.loading = false;
      });
    },

    onClientCreated(client) {
      this.clients.push(client);
    },
  },
};
</script>

<style lang="scss" scoped>

</style>
