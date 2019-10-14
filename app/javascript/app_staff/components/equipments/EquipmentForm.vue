<template lang="pug">
  div.q-pa-md.rounded-borders
    h6.q-mb-md.q-mt-sm
      | {{ editing ? 'Equipment' : 'Add Equipment'}}
    q-form(
      class="q-gutter-y-md column"
      ref="equipmentForm"
      @reset="onReset"
      @submit="onSubmit"
    )
      q-input(
        v-model="form.name"
        outlined
        label="Name *"
        hint="Enter name"
        placeholder="Name of equipment"
        :rules="rules.name"
        lazy-rules
      )
      q-select(
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
      q-input(
        v-model="form.serial_number"
        ref="inputSerialNumber"
        outlined
        label="Serial Number *"
        hint="Enter serial number"
        placeholder="R-R2D2"
        :rules="rules.serial_number"
        lazy-rules
      )
      q-select(
        v-model="form.organization_id"
        outlined
        :options="organizations"
        option-value="id"
        option-label="name"
        emit-value
        map-options
        label="Organization"
        hint="Select organization"
        lazy-rules
        :rules="rules.type"
      )
      div.row.q-pa-md.q-gutter-md.justify-end
        q-btn(label="Reset" type="reset" color="white" text-color="black")
        q-btn(label="Save" type="submit" color="primary")
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import { QForm, QInput, QSelect } from 'quasar';
import { validator, validatorErrors, VALIDATION_ERRORS } from 'staffApp/mixins/validator';

export default {
  components: {
    QForm,
    QInput,
    QSelect,
  },

  mixins: [validator, validatorErrors],

  props: {
    equipment: {
      type: Object,
    },
  },

  data() {
    return {
      form: {},
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

  computed: {
    ...mapGetters({
      types: 'equipments/types',
      organizations: 'organizations/organizations',
    }),

    editing() {
      return !!this.equipment;
    }
  },

  created() {
    this.fetchTypes();
    this.setDataForm(this.equipment);
    this.fetchOrganizations();
  },

  methods: {
    ...mapActions({
      fetchTypes: 'equipments/fetchTypes',
      createEquipment: 'equipments/create',
      updateEquipment: 'equipments/update',
      fetchOrganizations: 'organizations/fetchAll',
    }),

    onSubmit() {
      if (this.editing == true) {
        this.update();
      } else {
        this.create();
      }
    },

    onReset() {
      this.form = {};
      this.$refs.equipmentForm.resetValidation();
    },

    onUpdated(equipment) {
      this.$emit('equipment-updated', equipment);
    },

    setDataForm(equipment) {
      if (!equipment) { return; }
      ['name', 'type_equipment_id', 'serial_number', 'organization_id'].forEach(key => {
        this.form[key] = equipment[key];
      });
    },

    create() {
      this.createEquipment(this.form).then(() => {
        this.onReset();
      }).catch(error => {
        const errors = error.response.data.errors;
        this.fillErrors(errors);
      });
    },

    update() {
      this.updateEquipment({ id: this.equipment.id, params: this.form}).then(() => {
        this.onUpdated();
        this.onReset();
      }).catch(error => {
        const errors = error.response.data.errors;
        this.fillErrors(errors);
      });
    },
  },
};
</script>
