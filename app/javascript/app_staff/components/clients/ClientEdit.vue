<template lang="pug">
  app-modal(:title="'Edit'")
    .form-container
      client-form(v-if="client" :client="client" @client-updated="onClientUpdated")
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import AppModal from 'staffApp/components/AppModal';
import ClientForm from 'staffApp/components/clients/ClientForm';

export default {
  components: {
    AppModal,
    ClientForm,
  },

  computed: {
    ...mapGetters({
      client: 'clients/client',
    }),

    id() {
      return this.$route.params.id;
    },
  },

  mounted() {
    this.fetchClient(this.id);
  },

  methods: {
    ...mapActions({
      fetchClient: 'clients/fetchSingle',
    }),

    onClientUpdated() {
      this.$router.push({ name: 'clients.index'});
    }
  },
};
</script>

<style lang="styl" scoped>
  div.form-container {
    width: 400px;
  }
</style>
