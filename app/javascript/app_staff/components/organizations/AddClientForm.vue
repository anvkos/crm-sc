<template lang="pug">
  QForm(
    class="q-gutter-y-md column"
    ref="addClientForm"
    @reset="onReset"
    @submit="onSubmit"
  )
    QSelect(
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
        QBtn(type="submit" label="Add" color="primary")
</template>

<script>
import { QForm, QSelect } from 'quasar';
import Api from 'staffApi';
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
      clients: [],
      form: {},
      rules: {
        type: [value => !!value || VALIDATION_ERRORS.select('client')],
      },
    };
  },

  created() {
    this.fetchClients();
  },

  methods: {
    onSubmit() {
      Api.organizations.addClient(this.organization.id, this.form).then(data => {
        this.onAdded(data);
        this.onReset();
      });
    },

    onReset() {
      this.form = {};
      this.$refs.addClientForm.resetValidation();
    },

    fetchClients() {
      Api.clients.fetchAll().then(data => {
        data.forEach(item => this.clients.push({
            id: item.id,
            fullname: item.fullname,
          })
        );
      });
    },

    onAdded(client) {
      this.$emit('client-added', client);
    },
  },
};
</script>
