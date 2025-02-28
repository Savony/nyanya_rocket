import 'package:meta/meta.dart';
import 'package:nyanya_rocket/blocs/local_game_controller.dart';
import 'package:nyanya_rocket_base/nyanya_rocket_base.dart';

class EditorGameController extends LocalGameController {
  EditorGameController({@required Game game}) : super(game) {
    running = false;
  }

  void toggleTile(int x, int y, Tile tile) {
    if (game.board.tiles[x][y] is Empty) {
      game.board.tiles[x][y] = tile;
      updateGame();
    } else if (game.board.tiles[x][y].runtimeType == tile.runtimeType) {
      game.board.tiles[x][y] = Empty();
      updateGame();
    }
  }

  bool toggleEntity(int x, int y, EntityType type, Direction direction) {
    if (!running) {
      if (game.board.tiles[x][y] is Empty || game.board.tiles[x][y] is Arrow) {
        Iterable<Entity> there = game.entities.where((Entity entity) =>
            entity.position.x == x && entity.position.y == y);

        if (there.isEmpty) {
          game.entities.add(Entity.fromEntityType(
              type, BoardPosition.centered(x, y, direction)));

          updateGame();
          return true;
        } else if ((there.first is Mouse && type == EntityType.Mouse) ||
            (there.first is Cat && type == EntityType.Cat)) {
          game.entities.remove(there.first);
          updateGame();
        }
      }
    }

    return false;
  }

  bool toggleWall(int x, int y, Direction direction) {
    if (!running) {
      game.board.setWall(x, y, direction, !game.board.hasWall(direction, x, y));
      updateGame();
    }

    return false;
  }
}
