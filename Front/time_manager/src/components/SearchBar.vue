<template>
    <div class="search">
        <input type="text" class="searchTerm" placeholder="What are you looking for?">
        <button type="submit" class="searchButton">
            <img src="./../assets/imgs/search.png" style="width: 25px">
        </button>
    </div>
</template>

<script>
    export default {
        name: "SearchBar"
    }
</script>

<style scoped>
    .search {
        width: 100%;
        position: relative;
        display: flex;
    }

    .searchTerm {
        width: 100%;
        border: 3px solid #011936;
        border-right: none;
        padding: 5px;
        height: 20px;
        border-radius: 5px 0 0 5px;
        outline: none;
        color: #9DBFAF;
    }

    .searchTerm:focus{
        color: #011936;
    }

    .searchButton {
        width: 40px;
        height: 36px;
        border: 1px solid #011936;
        background: #011936;
        text-align: center;
        color: #fff;
        border-radius: 0 5px 5px 0;
        cursor: pointer;
        font-size: 20px;
    }
</style>