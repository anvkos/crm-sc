<template lang="pug">
  q-form(
    class="q-gutter-y-md column"
    ref="addClientForm"
    @reset="onReset"
    @submit="onSubmit"
  )
    q-select(
      v-model="form.client_id"
      dense
      outlined
      :options="clients"
      option-value="id"
      option-label="fullname"
      emit-value
      map-options
      label="Client"
      hint="Select client"
      lazy-rules
      :rules="rules.type"
    )
      template(v-slot:after)
        q-btn(type="submit" label="Add" color="primary")
</template>

<script>
import { QForm, QSelect } from 'quasar';
import { mapGetters, mapActions } from 'vuex';
import { VALIDATION_ERRORS } from 'staffApp/mixins/validator';

export default {
  components: {
    QForm,
    QSelect,
  },

  props: {
    organization: {
      type: Object,
      required: true,
    },
  },

  data() {
    return {
      form: {},
      rules: {
        type: [value => !!value || VALIDATION_ERRORS.select('client')],
      },
    };
  },

  computed: {
    ...mapGetters({
      clients: 'clients/clients',
    }),
  },

  created() {
    this.fetchClients();
  },

  methods: {
    ...mapActions({
      fetchClients: 'clients/fetchAll',
      addOrganizationClient: 'organizations/addClient',
    }),

    onSubmit() {
      this.addOrganizationClient({ id: this.organization.id, client: this.form }).then(() => {
        this.onReset();
      })
    },

    onReset() {
      this.form = {};
      this.$refs.addClientForm.resetValidation();
    },
  },
};
</script>
