assertion type beep(counter);

ground network {
  console.log('starting ground boot');

  actor {
    until {
      case asserted Syndicate.observe(beep(_)) {
        var counter = 0;
        state {
          init {
            :: beep(counter++);
          }
          on message beep(_) {
            :: beep(counter++);
          }
        } until {
          case (counter >= 10);
        }
      }
    }
  }

  actor {
    forever {
      on message $m {
        console.log("Got message:", m);
      }
    }
  }
}