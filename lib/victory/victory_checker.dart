import '../constants/constants.dart';
import '../victory/victory.dart';
class VictoryChecker{
  static Victory checkForVictory(List<List<String>> field,String playerChar){
    Victory v;
    //horizontal
    if(field[0][0].isNotEmpty &&
       field[0][0] == field[0][1] &&
       field[0][0] ==field [0][2]
    ){
      v = new Victory(0, 0,Constants.HORIZONTAL,
        field[0][0] ==playerChar ? Constants.PLAYER : Constants.AI
      );
    }else if(field[1][0].isNotEmpty &&
       field[1][0] == field[1][1] &&
       field[1][0] ==field [1][2]
    ){
      v = new Victory(1, 0, Constants.HORIZONTAL, 
      field[1][0] ==playerChar ? Constants.PLAYER : Constants.AI
      );
    }else if(field[2][0].isNotEmpty &&
       field[2][0] == field[2][1] &&
       field[2][0] ==field [2][2]
    ){
      v = new Victory(2, 0, Constants.HORIZONTAL, 
      field[2][0] ==playerChar ? Constants.PLAYER : Constants.AI
      );
    }
    //vertical
    else if(field[0][0].isNotEmpty &&
       field[0][0] == field[1][0] &&
       field[0][0] ==field [2][0]
    ){
      v = new Victory(0, 0,Constants.VERTICAL,
        field[0][0] ==playerChar ? Constants.PLAYER : Constants.AI
      );
    }else if(field[0][1].isNotEmpty &&
       field[0][1] == field[1][1] &&
       field[0][1] ==field [2][1]
    ){
      v = new Victory(0, 1, Constants.VERTICAL, 
      field[0][1] ==playerChar ? Constants.PLAYER : Constants.AI
      );
    }else if(field[0][2].isNotEmpty &&
       field[0][2] == field[1][2] &&
       field[0][2] ==field [2][2]
    ){
      v = new Victory(0, 2, Constants.VERTICAL, 
      field[0][2] ==playerChar ? Constants.PLAYER : Constants.AI
      );
    }
    //diagonal
    else if(field[0][0].isNotEmpty &&
             field[0][0] == field[1][1] &&
             field[0][0] == field[2][2]
    ){
      v= new Victory(0, 0, Constants.DIAGONAL_DESCENDING, 
      field[0][0] ==playerChar ? Constants.PLAYER : Constants.AI
      );
    }
    else if(field[2][0].isNotEmpty &&
             field[1][1] == field[2][0] &&
             field[0][2] == field[2][0]
    ){
      v= new Victory(2, 0, Constants.DIAGONAL_ASCENDING, 
      field[2][0] ==playerChar ? Constants.PLAYER : Constants.AI
      );
    }
    else if (field[0][0].isNotEmpty &&
             field[0][1].isNotEmpty &&
             field[0][2].isNotEmpty &&
             field[1][0].isNotEmpty &&
             field[1][1].isNotEmpty &&
             field[1][2].isNotEmpty &&
             field[2][0].isNotEmpty &&
             field[2][1].isNotEmpty &&
             field[2][2].isNotEmpty
    ){
      v = new Victory(-1, -1, -1, Constants.DRAFT);
    }
    return v;
  } 
}