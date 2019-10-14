<template lang="pug">
  app-modal(:title="'Edit'")
    .form-container
      organization-form(v-if="organization" :organization="organization" @organization-updated="onOrganizationUpdated")
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import AppModal from 'staffApp/components/AppModal';
import OrganizationForm from 'staffApp/components/organizations/OrganizationForm';

export default {
  components: {
    AppModal,
    OrganizationForm,
  },

  computed: {
    ...mapGetters({
      organization: 'organizations/organization',
    }),

    id() {
      return this.$route.params.id;
    },
  },

  mounted() {
    this.fetchOrganization(this.id);
  },

  methods: {
    ...mapActions({
      fetchOrganization: 'organizations/fetchSingle',
    }),

    onOrganizationUpdated() {
      this.$router.push({ name: 'organizations.index'});
    },
  },
};
</script>

<style lang="styl" scoped>
  div.form-container {
    width: 400px;
  }
</style>
