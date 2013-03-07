Date.prototype.toMyString = function () {

        function padZero(obj) {
              obj = obj + '';
              if (obj.length == 1)
                  obj = "0" + obj
              return obj;
        }

        var output = "";
        output += padZero(this.getDate()) + "-";
        output += padZero(this.getMonth()+1) + "-";
        output += this.getFullYear();

        return output; 
    };
