<template lang="pug">
  QHeader(reveal)
    QToolbar
      QBtn(flat @click="toggleVisibilitySidebar")
        QIcon( name="fas fa-bars")
      QToolbar-title
        QAvatar
          img(:src="require('staffImages/diamond.svg')")
        span(class="text-white text-weight-bold") Service Center

      span(v-if="user") {{ user.fullname }}
      QBtn(flat no-caps color="white" label="Sign out" @click="signOut")
        QIcon(name="fas fa-sign-out-alt" right size="xs")
</template>

<script>
import {
  QToolbar,
  QToolbarTitle,
  QAvatar,
  QIcon,
} from 'quasar'

export default {
  props: {
    user: {
      type: Object,
    },
    drawerLeft: {
      type: Boolean,
      default: true,
    },
  },

  components: {
    QToolbar,
    QToolbarTitle,
    QAvatar,
    QIcon,
  },

  methods: {
    toggleVisibilitySidebar() {
      this.$emit('click-toggle-visibility-sidebar');
    },

    signOut() {
      this.$emit('user-signout');
    }
  },

};
</script>
