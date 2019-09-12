<template>
    <div id="app">
        <search-bar></search-bar>
        <div id="app">
            <User class="block-container"></User>
            <WorkingTimes class="block-container" ></WorkingTimes>
            <WorkingTime class="block-container"></WorkingTime>
            <ClockManager class="block-container"></ClockManager>
            <ChartManager class="block-container" ></ChartManager>
        </div>
    </div>
</template>

<script>
import ClockManager from "./components/ClockManager";
import WorkingTime from "./components/WorkingTime";
import WorkingTimes from "./components/WorkingTimes";
import ChartManager from "./components/ChartManager";
import User from "./components/User";
import SearchBar from "./components/SearchBar";

export default {
  name: 'app',
  components: {
      SearchBar,
    User,
    ChartManager,
    WorkingTimes,
    WorkingTime,
    ClockManager
  }
}
</script>

<style>
  .block-container {
    min-width: 500px;
    width: 30%;
    height: 30%;
    margin: 10px;
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
    border-radius: 10px;
    flex-direction: column;
    background-color: whitesmoke;
  }

  html, body {
    height: 100%;
    width: 100%;
      background-color: #ccccaa;
    /*background-image: url("./assets/imgs/background.jpg");*/
    background-color: #113344;
  }


  #app {
    flex-wrap: wrap;
    display: flex;
    justify-content: center;
    height: 100%;
    width: 100%;
  }


</style>
