<template>
  <div class="container-row">
    <User
      @setColor="setColor"
      :infoUser="infoUser"
      class="block-container item-a"
      @setPeriod="setPeriod"
    ></User>
    <ChartManager :color="colors" ref="donut" class="block-container"></ChartManager>

    <WorkingTimes :datePeriod="period" :color="colors" ref="form" class="block-container item-b"></WorkingTimes>
    <WorkingTime @setPeriod="setPeriod" class="block-container"></WorkingTime>

    <ClockManager :infoUser="infoUser" @setStatus="setStatus" class="block-container"></ClockManager>
    <UserManager class="block-container"></UserManager>
  </div>
</template>

<style scoped>
.item-a {
  grid-column: 1;
  grid-row: 1 / 3;
}

.item-b {
  grid-column: 3 / span 2;
  grid-row: 2;
}

.container-row {
  width: 100%;
  height: 100%;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
  grid-auto-flow: dense;
  grid-gap: 10px;
}

@media screen and (max-width: 1300px) {
  .item-b {
    grid-column: 1 / span 2;
    grid-row: 3;
  }
}

.block-container {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
  border-radius: 10px;
  background-color: whitesmoke;
  min-height: 300px;
}
</style>

<script>
import ClockManager from "./../components/ClockManager";
import WorkingTime from "./../components/WorkingTime";
import WorkingTimes from "./../components/WorkingTimes";
import ChartManager from "./../components/ChartManager";
import User from "./../components/User";
import SearchBar from "./../components/SearchBar";
import UserManager from "./../components/UserManager";
import moment from "moment";

export default {
  name: "App",
  components: {
    SearchBar,
    User,
    ChartManager,
    WorkingTimes,
    WorkingTime,
    ClockManager,
    UserManager
  },
  data() {
    return {
      period: {
        date1: new Date(),
        date2: moment()
          .subtract(10, "days")
          .calendar()
      },
      colors: {
        color: "#d0bb48"
      },
      infoUser: {
        surname: "Batman",
        id: 69,
        mail: "batman.tropchou@malaise.com",
        status: false
      }
    };
  },
  mounted() {
    this.infoUser.id = localStorage.userId;
    this.infoUser.surname = localStorage.surname;
    this.infoUser.mail = localStorage.mail;
    this.infoUser.status = localStorage.status;
    this.infoUser.role = localStorage.role;
  },
  methods: {
    setColor(color) {
      this.colors.color = color;
      this.$refs.donut.setColor();
      this.$refs.form.setColor();
    },
    setPeriod(date) {
      this.period.date1 = date.date1;
      this.period.date2 = date.date2;
      this.$refs.form.getUser();
    },
    setStatus() {
      if (this.infoUser.status) {
        this.infoUser.status = false;
      } else {
        this.infoUser.status = true;
      }
    }
  }
};
</script>
