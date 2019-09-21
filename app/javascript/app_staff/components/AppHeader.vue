<template lang="pug">
  QHeader(reveal)
    QToolbar
      QBtn(flat @click="toggleVisibilitySidebar")
        QIcon( name="fas fa-bars")
      QToolbar-title
        QAvatar
          img(src="data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIj8+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiBoZWlnaHQ9IjY0cHgiIHZpZXdCb3g9Ii0yNyAwIDUxMiA1MTIiIHdpZHRoPSI2NHB4Ij48cGF0aCBkPSJtOTAuNzA3MDMxIDE1OS4xMzY3MTkgMTIzLjQ3MjY1Ny03MS4yODUxNTd2LTg3Ljg1MTU2MmwtMTk5LjU1NDY4OCAxMTUuMjEwOTM4em0wIDAiIGZpbGw9IiMwMDAwMDAiLz48cGF0aCBkPSJtNzUuNjYwMTU2IDMyNy43NzM0Mzh2LTE0Mi41NzAzMTNsLTc1LjY2MDE1Ni00My42ODM1OTR2MjI5LjkzNzV6bTAgMCIgZmlsbD0iIzAwMDAwMCIvPjxwYXRoIGQ9Im0zNTIuNjk5MjE5IDE4NS4yMDMxMjUtMTIzLjQ3MjY1Ny03MS4yODkwNjMtMTIzLjQ2ODc1IDcxLjI4OTA2M3YxNDIuNTcwMzEzbDEyMy40Njg3NSA3MS4yODUxNTYgMTIzLjQ3MjY1Ny03MS4yODUxNTZ6bTAgMCIgZmlsbD0iIzAwMDAwMCIvPjxwYXRoIGQ9Im0yNDQuMjc3MzQ0IDB2ODcuODUxNTYybDEyMy40Njg3NSA3MS4yODUxNTcgNzYuMDgyMDMxLTQzLjkyNTc4MXptMCAwIiBmaWxsPSIjMDAwMDAwIi8+PHBhdGggZD0ibTM4Mi43OTY4NzUgMTg1LjIwMzEyNXYxNDIuNTcwMzEzbDc1LjY1NjI1IDQzLjY4MzU5M3YtMjI5LjkzNzV6bTAgMCIgZmlsbD0iIzAwMDAwMCIvPjxwYXRoIGQ9Im0yMTQuMTc5Njg4IDQyNS4xMjUtMTIzLjQ3MjY1Ny03MS4yODUxNTYtNzUuMjM0Mzc1IDQzLjQzNzUgMTk4LjcwNzAzMiAxMTQuNzIyNjU2em0wIDAiIGZpbGw9IiMwMDAwMDAiLz48cGF0aCBkPSJtMzY3Ljc0NjA5NCAzNTMuODM5ODQ0LTEyMy40Njg3NSA3MS4yODUxNTZ2ODYuODc1bDE5OC43MDcwMzEtMTE0LjcyMjY1NnptMCAwIiBmaWxsPSIjMDAwMDAwIi8+PC9zdmc+Cg==")
        span(class="text-white text-weight-bold") Service Center

      span(v-if="user") {{ user.name }}
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
      this.$emit('user-signout', {});
    }
  },

};
</script>
