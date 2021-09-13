<template>
  <div>
    <svg-icon icon-class="question" @click="goto"/>
  </div>
</template>

<script>
export default {
  name: 'workflowDoc',
  data() {
    return {
      url: 'http://47.96.74.120'
    }
  },
  methods: {
    goto() {
      window.open(this.url)
    }
  }
}
</script>
