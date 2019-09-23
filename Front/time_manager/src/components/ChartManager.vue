<template>
  <div class="">
    <donut-chart id="donut" :data="donutData" :colors="textColor" resize="true"></donut-chart>
  </div>
</template>

<script>
import Raphael from "raphael/raphael";
global.Raphael = Raphael;
import { DonutChart } from "vue-morris";
import moment from "moment";

export default {
  name: "ChartManager",
  data() {
    return {
      textColor: [
        "#ff0000",
        "#36A2EB",
        "#ff0100",
        "#37A2EB",
        "#ff0040",
        "#26A2EB",
        "#fA0000"
      ],
      donutData: [
        { label: "Max", value: 7 },
        { label: "Ja", value: 3 },
        { label: "Louis", value: 7 },
        { label: "Joker", value: 3 },
        { label: "Batman", value: 7 },
        { label: "Gordon", value: 3 },
        { label: "Jef", value: 7 }
      ],
                datePeriod : {
              date1: new Date(),
              date2: moment().add(10, 'days').calendar()
          },
          colors : {
              color: ""
          },
          lineData : []

    };
  },
  components: {
    DonutChart
  },
  props: {
      color: {
          type: Object
      }
  },
  methods: {
    setColor() {      
      let colorsDec = [];
      let color = this.color.color.replace(/#/g, "");
      color = parseInt(color, 16);
      let i = 0;
      let tmpColor = color;
      while (this.textColor[i]) {
        colorsDec.push(color);
        if (color + tmpColor < 16777215) {
          color = Math.round(color + tmpColor);
        } else {
          color = Math.round(color / 7);
        }
        i++;
      }
      i = 0;
      while (this.textColor[i]) {
        colorsDec[i] = "#" + colorsDec[i].toString(16);
        i++;
      }
      this.textColor = colorsDec;
        this.donutData.push("");
        this.donutData.pop();
    }
  },
  created: function() {
      this.setColor();
  }
};
</script>
