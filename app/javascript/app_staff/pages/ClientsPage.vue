<template lang="pug">
  q-page
    div.row
      h4.q-mb-md.q-mt-sm Clients
    div.row
      div.col-8
        clients-list(:clients="clients")
      div.col-4
        client-form
    router-view
</template>

<script>
import { QPage } from 'quasar';
import { mapGetters, mapActions } from 'vuex';
import ClientsList from 'staffApp/components/clients/ClientsList';
import ClientForm from 'staffApp/components/clients/ClientForm';

export default {
  components: {
    ClientsList,
    ClientForm,
  },

  computed: {
    ...mapGetters({
      clients: 'clients/clients',
    }),
  },

  created() {
    this.fetchAll();
  },

  methods: {
    ...mapActions({
      fetchAll: 'clients/fetchAll',
    }),
  },
};
</script>
