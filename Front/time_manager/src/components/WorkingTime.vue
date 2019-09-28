<template>
  <div class="select-period">
    <h3 class="align-element">choose a period</h3>
    <div class="align-element">
      Working Days :
      <datepicker v-model="state.date2" placeholder="Select Date"></datepicker>
    </div>
    <div class="align-element">
      Working Days :
      <datepicker v-model="state.date1" placeholder="Select Date"></datepicker>
    </div>
    <div style="margin: 0 auto;">
        <b-button @click="sendDate" variant="outline-primary">Emit</b-button>
    </div>
  </div>
</template>

<style scoped>
    .select-period {
        display: grid;
        grid-template-rows: 75px 100px 100px 100px;
    }

    .align-element {
        margin-left: 25%;
    }
</style>

<script>
import Datepicker from "vuejs-datepicker";
import VueTimepicker from "vue2-timepicker";
import "vue2-timepicker/dist/VueTimepicker.css";
import moment from "moment";

import * as lang from "vuejs-datepicker/src/locale";

var state = {
  date1: new Date(),
  date2: new Date()
};

export default {
  components: {
    Datepicker,
    VueTimepicker
  },
  name: "work",
  data() {
    return {
      format: "d MMMM yyyy",
      disabledDates: {},
      disabledFn: {
        customPredictor(date) {
          if (date.getDate() % 3 === 0) {
            return true;
          }
        }
      },
      highlightedFn: {
        customPredictor(date) {
          if (date.getDate() % 4 === 0) {
            return true;
          }
        }
      },
      highlighted: {},
      eventMsg: null,
      state: state,
      language: "en",
      languages: lang,
      vModelExample: null,
      changedMonthLog: []
    };
  },
  methods: {
    sendDate() {
      this.state.date1.setHours(0);
      this.state.date2.setHours(0);
      this.state.date1.setMinutes(0);
      this.state.date2.setMinutes(0);
      this.$emit("setPeriod", this.state);
    }
  }
};
</script>
