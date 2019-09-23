<template>

<div style="display: grid; grid-template-rows: 100%; padding: 20px;">
      <b-button v-if="infoUser.status" @click="setStatus" variant="success">Working</b-button>
      <b-button v-if="!infoUser.status" @click="setStatus" variant="danger">Not Working</b-button>
</div>
  <!--<div>
    <button
      class="button-work text text-font"
      v-on:click="ClockManager"
      v-bind:style="{ backgroundColor: colorClock, color: textColorClock }"
      v-bind:disabled="btnClock == true"
    >Is working</button>
    <button
      class="button-work text text-font"
      v-on:click="ClockManager"
      v-bind:style="{ backgroundColor: colorUnclock, color: textColorUnclock }"
      v-bind:disabled="btnClock == false"
    >Is not working</button>
  </div>-->
</template>
<script>
export default {
  name: "ClockManager",
  props : {
      infoUser : {
          type: Object
      }
  },
  data() {
    return {
        variant:"success",
      colorClock: "#bbccbb",
      colorUnclock: "#113344",
      textColorClock: "#113344",
      textColorUnclock: "#bbccbb",
      btnClock: true
    };
  },
  methods: {
    ClockManager() {
      if (this.btnClock) {
        this.btnClock = false;
        this.colorClock = "#113344";
        this.colorUnclock = "#bbccbb";
        this.textColorClock = "#bbccbb";
        this.textColorUnclock = "#113344";
      } else {
        this.btnClock = true;
        this.colorClock = "#bbccbb";
        this.colorUnclock = "#113344";
        this.textColorClock = "#113344";
        this.textColorUnclock = "#bbccbb";
      }
    },
    setStatus () {
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
