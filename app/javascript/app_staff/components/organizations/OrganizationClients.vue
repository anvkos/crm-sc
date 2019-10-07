<template lang="pug">
  AppModal(:title="'Clients of organization'")
    ClientsList(:clients="clients")
</template>

<script>
import Api from 'staffApi';
import AppModal from 'staffApp/components/AppModal';
import ClientsList from 'staffApp/components/organizations/ClientsList';

export default {
  components: {
    AppModal,
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
  },
};
</script>
