<template>
  <div style="display: grid; grid-template-rows: 100%; padding: 20px;">
    <b-button v-if="infoUser.status" @click="setStatus" variant="success">Working</b-button>
    <b-button v-if="!infoUser.status" @click="setStatus" variant="danger">Not Working</b-button>
  </div>
</template>
<script>
export default {
  name: "ClockManager",
  props: {
    infoUser: {
      type: Object
    }
  },
  methods: {
    setStatus() {
      this.$emit("setStatus");
    }
  }
};
</script>

<style scoped>
.button-work {
  border-radius: 10%;
  height: 30%;
  width: 90%;
  margin: 3%;
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  cursor: pointer;
}

.text {
  white-space: nowrap;
  font-weight: bold;
}
</style>
