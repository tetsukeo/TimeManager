<template>
  <div>
    <line-chart
      id="line"
      :data="lineData"
      xkey="day"
      ykeys='["tetsukeo","maxou"]'
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
import Axios from "axios";

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
    return {
      idTmp: -1,
      userNb: 0,
      workingTimes: null,
      infos: null,
      users: [],
      textColor: [
        "#ff0000",
        "#36A2EB"
      ],
      lineData: [],
      serie: [
        "Serie A",
        "Serie B"
      ],
      line: []
    };
  },
  components: {
    LineChart
  },
  computed: {},
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
    },
    setLineChart () {
      let i = 0;
      let tlineData = [];
      let diff = (new Date(this.datePeriod.date1) - new Date(this.datePeriod.date2)) / (1000 * 3600 * 24);
      while (i <= diff) {
        
        let newDay = moment(this.datePeriod.date1).subtract(diff - (i + 1), "days")._d;
        var user = 0;
        var days = {days: moment(String(newDay)).format("YYYY-MM-DD")}
        var day = {day: moment(String(newDay)).format("YYYY-MM-DD")}
        var obj = null;
        obj = Object.assign({}, day, days)   
        while (this.infos[user]) {
          obj[this.infos[user][0]] = this.infos[user][2][i];
          user++;
        }
        i++;
        tlineData.push(obj);
      }
      console.log("Fin set Line Chart");
      console.log(tlineData);

            this.lineData = tlineData;

    },
    getUser() {
      this.idTmp= -1;
      this.userNb = 0;
      this.workingTimes= null;
      this.infos= null;
      this.users= [];
      this.textColor = [
        "#ff0000",
        "#36A2EB"
      ],
      this.lineData = [],
      this.serie = [
        "Serie A",
        "Serie B"
      ],
      this.line = [];
      console.log("get User");
      
      Axios.get("http://127.0.0.1:4000/api/users", {
        headers: { Authorization: `Bearer ${localStorage.token}` }
      })
        .then(response => {          
          this.infos = JSON.stringify(response.data);
          this.infos = JSON.parse(this.infos);
          let i = 0;
          console.log(this.infos);
          
          while (this.infos[i]) {
            this.users.push(this.infos[i])
            i++;
          }          
          this.setChartUser();
        })
        .catch(e => console.log(e));
    },

    betweenTwoDate(start, end, startPeriod, endPeriod) {

      if (start >= startPeriod) {

        if (start < endPeriod) {

          if (end > startPeriod) {

            if (end <= endPeriod) {

              return true;
            }
          }
        }
      }
      return false;
    },

    setWorkingTime(id, workingTimes) {
      var i = 0;
      var HoursWork = 0;
      var find = false;
      var startPeriod = new Date(this.datePeriod.date2);
      var arrayHours = [];
      var endPeriod = new Date(this.datePeriod.date1);

      while (startPeriod <= endPeriod ) {
        i = 0;
        HoursWork = 0;
        find = false;
        while (workingTimes[i]) {        
          var start = new Date(workingTimes[i].start);
          var end = new Date(workingTimes[i].end);
          start.setHours(start.getHours() - 2);
          end.setHours(end.getHours() - 2);          
          if (
            this.betweenTwoDate(
              start,
              end,
              startPeriod,
              moment(startPeriod).add(1, "days")._d
            )
          ) {
            find = true;            
            HoursWork = HoursWork + (new Date(workingTimes[i].end) - new Date(workingTimes[i].start)) / 1000 / 3600;
            i++;
          } else {
            i++;
          }
        }
        if (find == false) arrayHours.push(0)
        else arrayHours.push(HoursWork)
        startPeriod = moment(startPeriod).add(1, "days")._d;
      };
      this.infos[id].push(arrayHours);           
    },

    getWorkingTime(id) {      
      if (id == this.idTmp) {
        return;
      }

      Axios.get("http://127.0.0.1:4000/api/workingtimes/" + this.infos[id][1], {
        headers: { Authorization: `Bearer ${localStorage.token}` }
      })
        .then(response => {
          var workingTimes = JSON.stringify(response.data);
          workingTimes = JSON.parse(workingTimes);
          this.setWorkingTime(id, workingTimes);
          if (id + 1 < this.userNb) {
            this.getWorkingTime(id + 1);
          }
          if ((id + 1) >= this.userNb) {
              this.setLineChart()
          }
        })
        .catch(e => console.log(e));
    },
    setChartUser() {      
      var user = [];
      var i = 0;

      while (this.infos[i]) {
        user.push([this.infos[i].username, this.infos[i].id]);
        i++;
      }
      this.userNb = i;
      this.infos = user;      
      var id = 0;      
      this.getWorkingTime(id);
      id++;
    }
  },
  created: function() {
    this.setColor();
  },
  mounted() {       
    this.getUser();
  }
};
</script>
