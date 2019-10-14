<template lang="pug">
  app-modal(:title="'Clients of organization'")
    template
      add-client-form(:organization="{ id: id }")
      clients-list(:clients="clients")
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import AppModal from 'staffApp/components/AppModal';
import ClientsList from 'staffApp/components/organizations/ClientsList';
import AddClientForm from 'staffApp/components/organizations/AddClientForm';

export default {
  components: {
    AppModal,
    AddClientForm,
    ClientsList,
  },

  computed: {
    ...mapGetters({
      clients: 'organizations/organizationClients',
    }),

    id() {
      return this.$route.params.id;
    },
  },

  mounted() {
    this.fetchClients(this.id);
  },

  methods: {
    ...mapActions({
      fetchClients: 'organizations/fetchClients',
    }),
  },
};
</script>
