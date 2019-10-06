<template lang="pug">
  div.q-pa-md.rounded-borders
    h6.q-mb-md.q-mt-sm
      | Add Equipment
    QForm(
      class="q-gutter-y-md column"
      ref="equipmentForm"
      @reset="onReset"
      @submit="onSubmit"
    )
      QInput(
        v-model="form.name"
        outlined
        label="Name *"
        hint="Enter name"
        placeholder="Name of equipment"
        :rules="rules.name"
        lazy-rules
      )
      QSelect(
        v-model="form.type_equipment_id"
        outlined
        :options="types"
        option-value="id"
        option-label="name"
        emit-value
        map-options
        label="Type"
        hint="Select equipment type"
        lazy-rules
        :rules="rules.type"
      )
      QInput(
        v-model="form.serial_number"
        ref="inputSerialNumber"
        outlined
        label="Serial Number *"
        hint="Enter serial number"
        placeholder="R-R2D2"
        :rules="rules.serial_number"
        lazy-rules
      )
      div.row.q-pa-md.q-gutter-md.justify-end
        QBtn(label="Reset" type="reset" color="white" text-color="black")
        QBtn(label="Save" type="submit" color="primary")
</template>

<script>
import Api from 'staffApi';
import { QForm, QInput, QSelect } from 'quasar';
import { validator, validatorErrors, VALIDATION_ERRORS } from 'staffApp/mixins/validator';

export default {
  components: {
    QForm,
    QInput,
    QSelect,
  },

  mixins: [validator, validatorErrors],

  data() {
    return {
      form: {},
      types: [
        { id: 1, name: 'Type_1' },
        { id: 2, name: 'Type_2' },
        { id: 3, name: 'Type_3' },
      ],
      rules: {
        name: [
          value => !!value || VALIDATION_ERRORS.required,
          value => this.isLengthGreatThan(value, 5) || VALIDATION_ERRORS.minumim_length(5),
        ],
        type: [value => !!value || VALIDATION_ERRORS.select('equipment')],
        serial_number: [
          value => !!value || VALIDATION_ERRORS.required,
          value => this.isLengthGreatThan(value, 5) || VALIDATION_ERRORS.minumim_length(5),
        ],
      },

    };
  },

  methods: {
    onSubmit() {
      Api.equipments.create(this.form).then(data => {
        this.onCreated(data);
        this.onReset();
      }).catch(error => {
        const errors = error.response.data.errors;
        this.fillErrors(errors);
      });
    },

    onReset() {
      this.form = {};
      this.$refs.equipmentForm.resetValidation();
    },

    onCreated(equipment) {
      this.$emit('equipment-created', equipment);
    },
  },
};
</script>
