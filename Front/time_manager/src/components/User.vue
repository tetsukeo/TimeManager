<template>
    <div style="display: flex; flex-direction: row">
        <img class="avatar" src="./../assets/imgs/profile.jpeg">
        <div class="info text">
            <p>Username : </p>
            <p>UserId : </p>
            <p>Mail : </p>
        </div>
        <div style="bottom: 0; position: relative; text-align: center; padding-top: 170px">
            <a class="square_btn">ADD A NEW EMPLOYEE</a>
        </div>
    </div>
</template>

<script>
    export default {
        name: "User"
    }
</script>

<style scoped>

    .text {
        font-weight: bold;
    }

    .avatar {
        margin: 30px;
        width: 100px;
        height: 100px;
        border-radius: 50%;
    }

    .square_btn {
        position: absolute;
        display: inline-block;
        font-weight: bold;
        padding: 12px 0 8px;
        text-decoration: none;
        color: #011936;
        transition: .4s;
    }

    .square_btn:before{
        position: absolute;
        content: '';
        width: 100%;
        height: 4px;
        top:100%;
        left: 0;
        border-radius: 3px;
        background:#011936;
        transition: .2s;
    }

    .square_btn:after{
        position: absolute;
        content: '';
        width: 100%;
        height: 4px;
        top:0;
        left: 0;
        border-radius: 3px;
        background:#011936;
        transition: .2s;
    }

    .square_btn:hover:before {
        top: -webkit-calc(100% - 3px);
        top: calc(100% - 3px);
    }

    .square_btn:hover:after {
        top: 3px;
    }

</style>