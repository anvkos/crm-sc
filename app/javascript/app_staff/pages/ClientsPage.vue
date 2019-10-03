<template lang="pug">
  QPage
    div.row
      h4.q-mb-md.q-mt-sm Clients
    div.row
      div.col-8
        ClientsList(:clients="clients")
      div.col-4
        ClientForm(@client-created="onClientCreated")
    AppModal(v-if="showModal" :title="'Edit'")
      router-view(name="modal")
</template>

<script>
import { QPage } from 'quasar';
import AppModal from 'staffApp/components/AppModal';
import ClientsList from 'staffApp/components/clients/ClientsList';
import ClientForm from 'staffApp/components/clients/ClientForm';
import Api from 'staffApi';

export default {
  components: {
    AppModal,
    ClientsList,
    ClientForm,
  },

  data() {
    return {
      loading: true,
      clients: [],
      showModal: this.$route.meta.showModal,
    };
  },

  watch: {
    "$route.meta"({ showModal }) {
      this.showModal = showModal;
    }
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
