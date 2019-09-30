<template>
  <div class>
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
      donutData: [],
      datePeriod: {
        date1: new Date(),
        date2: moment()
          .add(10, "days")
          .calendar()
      },
      colors: {
        color: ""
      },
      lineData: []
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
    setInfos(infos) {
      this.donutData = [];
      let i = 0;
      let h = 0;
      let moy = 0;
      let obj = {};
      while (i < infos.length) {
        h = 0;
        moy = 0;
        let test = infos[i][2];

        while (h < test.length) {
          moy = moy + infos[i][2][h];
          h++;
        }
        if (moy > 0) moy = moy / h;

        obj["label"] = infos[i][0];
        obj["value"] = moy;

        this.donutData.push({ label: infos[i][0], value: moy });
        i++;
      }
    },
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
