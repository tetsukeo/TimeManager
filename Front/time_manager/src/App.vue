<template>
    <div>

        <div class="container">
            <search-bar class="block-full"></search-bar>
            <User class="block-container"></User>
            <ClockManager class="block-container"></ClockManager>
            <WorkingTime class="block-container"></WorkingTime>
            <ChartManager class="block-container"></ChartManager>
            <WorkingTimes class="block-container block-full"></WorkingTimes>


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
