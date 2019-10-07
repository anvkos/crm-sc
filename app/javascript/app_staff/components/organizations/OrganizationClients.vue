<template lang="pug">
  AppModal(:title="'Clients of organization'")
    template
      AddClientForm(:organization="{ id: id }" @client-added="onClientAdded")
      ClientsList(:clients="clients")
</template>

<script>
import Api from 'staffApi';
import AppModal from 'staffApp/components/AppModal';
import ClientsList from 'staffApp/components/organizations/ClientsList';
import AddClientForm from 'staffApp/components/organizations/AddClientForm';

export default {
  components: {
    AppModal,
    AddClientForm,
    ClientsList,
  },

  data() {
    return {
      clients: [],
    };
  },

  computed: {
    id() {
      return this.$route.params.id;
    },
  },

  mounted() {
    this.fetchClients(this.id);
  },

  methods: {
    fetchClients(id) {
      Api.organizations.fetchClients(id).then(data => {
        this.clients = data;
      });
    },

    onClientAdded(client) {
      this.clients.push(client);
    },
  },
};
</script>
