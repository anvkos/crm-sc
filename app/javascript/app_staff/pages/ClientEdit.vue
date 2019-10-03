<template lang="pug">
  .form-container
    ClientForm(v-if="client" :client="client" @client-updated="onClientUpdated")
</template>

<script>
import Api from 'staffApi';
import ClientForm from 'staffApp/components/clients/ClientForm';

export default {
  components: {
    ClientForm,
  },

  data() {
    return {
      client: null,
    };
  },

  computed: {
    id() {
      return this.$route.params.id;
    },
  },

  mounted() {
    this.fetchClient(this.id);
  },

  methods: {
    fetchClient(id) {
      Api.clients.fetch(id).then(data => {
        this.client = data;
      });
    },

    onClientUpdated() {
      this.$router.go(-1);
    }
  },
};
</script>
<style lang="styl" scoped>
  div.form-container {
    width: 400px;
  }
</style>
