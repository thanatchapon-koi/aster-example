*** Variables ***
${generate_recaptcha_token_btn}    //*[@class="relative mt-10 md:w-1/5 text-white bg-gradient-to-br from-pink-500 to-orange-400 hover:bg-gradient-to-bl font-medium rounded-lg text-xl px-5 py-2.5 text-center mr-2 mb-2 disabled:opacity-75 disabled:cursor-not-allowed"]
${copy_recaptcha_token_btn}    //*[@id="__next"]/div/div[1]/div[1]/div/button[2]
${recaptcha_text}    //p[@class= "mt-12 text-white"]


${generate_recaptcha_token_btn}    //*[@class="relative mt-10 md:w-1/5 text-white bg-gradient-to-br from-pink-500 to-orange-400 hover:bg-gradient-to-bl font-medium rounded-lg text-xl px-5 py-2.5 text-center mr-2 mb-2 disabled:opacity-75 disabled:cursor-not-allowed"]

#nav bar
${home_btn}    href="/"
${games_btn}    href="/rov-tournament/"
${faucet_btn}    href="/faucet/"
${reward_btn}    href="/reward/"

#wording
${aster_title}    Aster | Arise by INFINITAS

#
${recaptcha_token_page}    test/index.html
