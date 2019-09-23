<template>
  <div>
    <line-chart
      id="line"
      :data="lineData"
      xkey="day"
      ykeys='["a","b", "c", "d", "e", "f", "g"]'
      resize="true"
      :labels="serie"
      :line-colors="textColor"
      grid="true"
      grid-text-weight="bold"
    ></line-chart>
  </div>
</template>

<script>
import Raphael from "raphael/raphael";
global.Raphael = Raphael;
import { LineChart } from "vue-morris";
import moment from "moment";
import { log } from "util";
export default {
  name: "WorkingTime",
  props: {
    datePeriod: {
      type: Object
    },
    color: {
      type: Object
    }
  },
  data() {
    let i = 0;
    let tlineData = [];
    while (
      i <=
      (new Date(this.datePeriod.date2) - new Date(this.datePeriod.date1)) /
        (1000 * 3600 * 24)
    ) {
      let newDay = moment(this.datePeriod.date1).add(i, "days")._d;
      tlineData.push({
        days: moment(String(newDay)).format("YYYY-MM-DD"),
        a: 10,
        b: 5,
        c:6,
        d:7,
        e:8,
        f:9,
        g:4,
        day: moment(String(newDay)).format("YYYY-MM-DD")
      });
      i = i + 1;
    }
    return {
      textColor: ["#ff0000", "#36A2EB", "#ff0100", "#37A2EB", "#ff0040", "#26A2EB", "#fA0000"],
      lineData: tlineData,
      serie: ["Serie A", "Serie B","Serie C", "Serie D","Serie E", "Serie F","Serie G"],
      nbEmployee: 2,
      line: tlineData
    };
  },
  components: {
    LineChart
  },
  computed: {},
  methods: {
    setColor() {
      let colorsDec = [];
      let color = this.color.color.replace(/#/g, '')
      color = parseInt(color, 16)
    let i = 0;
    let tmpColor = color
      while (this.textColor[i]) {
          colorsDec.push(color)
          if ((color + tmpColor) < 16777215) {
            color = Math.round(color + tmpColor);
            
          } else {              
              color = Math.round(color / 7);
          }
          i++;
      }      
      i = 0;
      while (this.textColor[i]) {
          colorsDec[i] = '#' + colorsDec[i].toString(16);
          i++;
      }
      this.textColor = colorsDec
      this.setPeriod();
      
    },
    setPeriod() {
      let i = 0;
      let tlineData = [];
      while (
        i <=
        (new Date(this.datePeriod.date2) - new Date(this.datePeriod.date1)) /
          (1000 * 3600 * 24)
      ) {
        let newDay = moment(this.datePeriod.date1).add(i, "days")._d;
        tlineData.push({
          days: moment(String(newDay)).format("YYYY-MM-DD"),
        a: 10,
        b: 5,
        c:6,
        d:7,
        e:8,
        f:9,
        g:4,
          day: moment(String(newDay)).format("YYYY-MM-DD")
        });
        i = i + 1;
      }
      this.lineData = tlineData;
    }
  },
  created: function() {
      this.setColor()
  }
};
</script>
