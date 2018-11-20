<?php

/**
 * Class Application
 */
class Application
{

    /**
     * @var mixed
     */
    protected $timeStart;

    protected $debugString;

    /**
     * Application constructor.
     */
    public function __construct()
    {
        $software = $_SERVER['SERVER_SOFTWARE'];
        $userAgent = $_SERVER['HTTP_USER_AGENT'];
        $this->debugString = 'SOFTWARE: ' . $software . '\r\nUser-Agent:' . $userAgent;
    }

    /**
     * @return string
     */
    protected function timerLogger()
    {
        return number_format(microtime(true) - $this->timeStart, 3);
    }

    /**
     * @param $result
     * @param int $count
     * @return string
     */
    private function mathTest($count = 999999)
    {
        $mathFunctions = ["abs", "acos", "asin",
            "atan", "bindec", "floor", "exp",
            "sin", "tan", "pi", "is_finite",
            "is_nan", "sqrt"];

        for ($i = 0; $i < $count; $i++) {
            foreach ($mathFunctions as $function) {
                call_user_func_array($function, array($i));
            }
        }
        return $this->timerLogger() . ' seconds.';
    }


    /**
     * @return string
     */
    public function handle()
    {
        return $this->debugString . '\r\nMath test results: ' . $this->mathTest();
    }
}

$app = new Application();
echo($app->handle());
