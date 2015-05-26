//built with clientside 0.5.1 https://github.com/jgallen23/clientside
if (typeof __cs == 'undefined') {
  var __cs = { 
    map: {}, 
    libs: {},
    r: function(p) {
      var mod = __cs.libs[__cs.map[p]];
      if (!mod) {
        throw new Error(p + ' not found');
      }
      return mod;
    }
  };
  window.require = __cs.r;
}
__cs.map['./engine/pieces/king'] = 'cs47052e70';
__cs.map['./engine/pieces/queen'] = 'cs7242a7f4';
__cs.map['./engine/pieces/rook'] = 'csd72de993';
__cs.map['./engine/pieces/bishop'] = 'cs375b291b';
__cs.map['./engine/pieces/knight'] = 'cs0a15ea7e';
__cs.map['./engine/pieces/pawn'] = 'cs1d0f4d7e';
__cs.map['./engine/board'] = 'cs18cf41c2';
__cs.map['./piece'] = 'cs11bbc1d6';
__cs.map['./pieces/piece'] = 'cs11bbc1d6';
__cs.map['./pieces/king'] = 'cs47052e70';
__cs.map['./pieces/queen'] = 'cs7242a7f4';
__cs.map['./pieces/rook'] = 'csd72de993';
__cs.map['./pieces/bishop'] = 'cs375b291b';
__cs.map['./pieces/knight'] = 'cs0a15ea7e';
__cs.map['./pieces/pawn'] = 'cs1d0f4d7e';

//piece.js
__cs.libs.cs11bbc1d6 = (function(require, module, exports) {
(function() {
  var Piece,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };
  Piece = (function() {
    function Piece(opts) {
      this.assign_color(opts);
      this.assign_board(opts);
      this.assign_position(opts);
    }
    Piece.prototype.assign_color = function(opts) {
      var color, colors;
      if (!('color' in opts)) {
        throw "Please provide a piece color";
      }
      color = opts.color.toLowerCase();
      if (__indexOf.call(colors = ['white', 'black', 'grey'], color) < 0) {
        throw "Piece color must be one of " + (colors.join(', '));
      }
      return this.color = color;
    };
    Piece.prototype.assign_board = function(opts) {
      var _ref, _ref1;
      if (!('board' in opts)) {
        throw "Please provide a board";
      }
      if (((_ref = opts.board) != null ? (_ref1 = _ref.constructor) != null ? _ref1.name : void 0 : void 0) !== 'Board') {
        throw "Specified 'board' is not a Board";
      }
      return this.board = opts.board;
    };
    Piece.prototype.assign_position = function(opts) {
      if (!('position' in opts)) {
        throw "Please provide a position";
      }
      if (!(opts.position instanceof Array && opts.position.length === 2)) {
        throw "Position must be an array of two integers.";
      }
      this.position = opts.position;
      return this.board.board[this.position[0]][this.position[1]] = this;
    };
    Piece.prototype.x = function() {
      return this.position[0];
    };
    Piece.prototype.y = function() {
      return this.position[1];
    };
    return Piece;
  })();
  module.exports = Piece;
}).call(this);
return module.exports || exports;
})(__cs.r, {}, {});

//king.js
__cs.libs.cs47052e70 = (function(require, module, exports) {
(function() {
  var King, Piece,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };
  Piece = require('./piece');
  King = (function(_super) {
    __extends(King, _super);
    function King(opts) {
      King.__super__.constructor.apply(this, arguments);
      this.type = 'king';
    }
    return King;
  })(Piece);
  module.exports = King;
}).call(this);
return module.exports || exports;
})(__cs.r, {}, {});

//queen.js
__cs.libs.cs7242a7f4 = (function(require, module, exports) {
(function() {
  var Piece, Queen,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };
  Piece = require('./piece');
  Queen = (function(_super) {
    __extends(Queen, _super);
    function Queen(opts) {
      Queen.__super__.constructor.apply(this, arguments);
      this.type = 'queen';
    }
    return Queen;
  })(Piece);
  module.exports = Queen;
}).call(this);
return module.exports || exports;
})(__cs.r, {}, {});

//rook.js
__cs.libs.csd72de993 = (function(require, module, exports) {
(function() {
  var Piece, Rook,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };
  Piece = require('./piece');
  Rook = (function(_super) {
    __extends(Rook, _super);
    function Rook(opts) {
      Rook.__super__.constructor.apply(this, arguments);
      this.type = 'rook';
    }
    return Rook;
  })(Piece);
  module.exports = Rook;
}).call(this);
return module.exports || exports;
})(__cs.r, {}, {});

//bishop.js
__cs.libs.cs375b291b = (function(require, module, exports) {
(function() {
  var Bishop, Piece,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };
  Piece = require('./piece');
  Bishop = (function(_super) {
    __extends(Bishop, _super);
    function Bishop(opts) {
      Bishop.__super__.constructor.apply(this, arguments);
      this.type = 'bishop';
    }
    return Bishop;
  })(Piece);
  module.exports = Bishop;
}).call(this);
return module.exports || exports;
})(__cs.r, {}, {});

//knight.js
__cs.libs.cs0a15ea7e = (function(require, module, exports) {
(function() {
  var Knight, Piece,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };
  Piece = require('./piece');
  Knight = (function(_super) {
    __extends(Knight, _super);
    function Knight(opts) {
      Knight.__super__.constructor.apply(this, arguments);
      this.type = 'knight';
    }
    Knight.prototype.normalize_position = function(x, y) {
      x += 24;
      if (y > 5) {
        x += 12;
      }
      if (y > 5) {
        y -= y % 5;
      }
      return [x % 24, !(y < 0) ? y : void 0];
    };

    /*
     * List the moves available to a knight (in an array of [x, y] positions).
     *
     * Recall that it can capture in L shapes all around the board.
     */
    Knight.prototype.moves = function() {
      var d, positions, sign1, sign2, x, y, _i, _j, _k, _ref, _ref1;
      positions = [];
      for (sign1 = _i = -1; _i <= 1; sign1 = _i += 2) {
        for (sign2 = _j = -1; _j <= 1; sign2 = _j += 2) {
          for (d = _k = 1; _k <= 2; d = ++_k) {
            _ref = this.normalize_position(this.x() + sign1 * d, this.y() + sign2 * (3 - d)), x = _ref[0], y = _ref[1];
            if ((y == null) || ((_ref1 = this.board.piece_at(x, y)) != null ? _ref1.color : void 0) === this.color) {
              continue;
            }
            positions.push([x, y]);
          }
        }
      }
      return positions;
    };
    return Knight;
  })(Piece);
  module.exports = Knight;
}).call(this);
return module.exports || exports;
})(__cs.r, {}, {});

//pawn.js
__cs.libs.cs1d0f4d7e = (function(require, module, exports) {
(function() {
  var Pawn, Piece,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };
  Piece = require('./piece');
  Pawn = (function(_super) {
    __extends(Pawn, _super);
    function Pawn(opts) {
      Pawn.__super__.constructor.apply(this, arguments);
      this.type = 'pawn';
      this.initialize_unmoved();
      this.initialize_direction();
    }

    /*
     * With pawns, we must be careful about the direction in which
     * they move forward. For example, if a pawn crosses the inner circle
     * it is moving "backward" in relation to the pawns that started on that
     * side, which are moving forward.
     *
     * To record this moving direction, we simply maintain the convention that
     * @towards_center = true implies the pawn is moving toward the center, and
     * @towards_center = false implies the pawn is moving away from the center.
     *
     * A pawn changes direction if and only if it crosses the center circle.
     */
    Pawn.prototype.initialize_direction = function() {
      return this.towards_center = true;
    };

    /*
     * If a pawn has moved, it can no longer skip 2 spaces nor capture en passent.
     * We must record this somehow, simply as a boolean flag.
     */
    Pawn.prototype.initialize_unmoved = function() {
      return this.unmoved = true;
    };

    /*
     * List the moves available to a pawn (in an array of [x, y] positions).
     *
     * Recall that it can capture to the sideways left and right, but only move
     * forward. Adjacent to the center, the pawn can cross the center, or 
     * capture along the same diagonal a bishop would be able to.
     */
    Pawn.prototype.moves = function() {
      if (this.y() === 5 && this.towards_center) {
        return this.center_moves();
      } else {
        return this.noncenter_moves();
      }
    };
    Pawn.prototype.center_moves = function() {
      var i, moves, _i, _len, _ref;
      moves = [];
      if (!this.board.has_piece_at((this.x() + 12) % 24, this.y())) {
        moves.push([(this.x() + 12) % 24, this.y()]);
      }
      _ref = [-1, 1];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        i = _ref[_i];
        if (this.board.has_piece_at((this.x() + 12 + 2 * i) % 24, this.y()) && this.board.piece_at((this.x() + 12 + 2 * i) % 24, this.y()).color !== this.color) {
          moves.push([(this.x() + 12 + 2 * i) % 24, this.y()]);
        }
      }
      return moves;
    };
    Pawn.prototype.noncenter_moves = function() {
      var delta, i, moves, _i, _len, _ref;
      moves = [];
      if (this.unmoved && !this.board.has_piece_at(this.x(), this.y() + 2) && !this.board.has_piece_at(this.x(), this.y() + 1)) {
        moves.push([this.x(), this.y() + 2]);
      }
      delta = this.towards_center ? 1 : -1;
      if (!this.board.has_piece_at(this.x(), this.y() + delta)) {
        moves.push([this.x(), this.y() + delta]);
      }
      _ref = [-1, 1];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        i = _ref[_i];
        if ((this.board.has_piece_at(this.x() + i, this.y() + delta)) && (this.board.piece_at(this.x() + i, this.y() + delta).color !== this.color)) {
          moves.push([this.x() + i, this.y() + delta]);
        }
      }
      return moves;
    };
    return Pawn;
  })(Piece);
  module.exports = Pawn;
}).call(this);
return module.exports || exports;
})(__cs.r, {}, {});

//board.js
__cs.libs.cs18cf41c2 = (function(require, module, exports) {
(function() {
  var Bishop, Board, King, Knight, Pawn, Queen, Rook;
  King = require('./pieces/piece');
  King = require('./pieces/king');
  Queen = require('./pieces/queen');
  Rook = require('./pieces/rook');
  Bishop = require('./pieces/bishop');
  Knight = require('./pieces/knight');
  Pawn = require('./pieces/pawn');
  Board = (function() {
    function Board(setup_pieces) {
      if (setup_pieces == null) {
        setup_pieces = true;
      }
      this.initialize_board();
      if (setup_pieces) {
        this.initialize_pieces();
      }
    }
    Board.prototype.initialize_board = function() {
      var $, _;
      this.colors = ['white', 'grey', 'black'];
      return this.board = (function() {
        var _i, _results;
        _results = [];
        for ($ = _i = 0; _i <= 23; $ = ++_i) {
          _results.push((function() {
            var _j, _results1;
            _results1 = [];
            for (_ = _j = 0; _j <= 5; _ = ++_j) {
              _results1.push(null);
            }
            return _results1;
          })());
        }
        return _results;
      })();
    };
    Board.prototype.initialize_pieces = function() {
      var color, _i, _len, _ref, _results;
      _ref = this.colors;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        color = _ref[_i];
        this.initialize_backrank(color);
        _results.push(this.initialize_pawns(color));
      }
      return _results;
    };
    Board.prototype.initialize_backrank = function(color) {
      var color_name, i, _i, _ref, _results;
      _ref = [color, this.colors.indexOf(color)], color_name = _ref[0], color = _ref[1];
      this.backrank_pieces || (this.backrank_pieces = [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]);
      _results = [];
      for (i = _i = 0; _i <= 7; i = ++_i) {
        _results.push(new this.backrank_pieces[i]({
          color: color_name,
          board: this,
          position: [8 * color + i, 0]
        }));
      }
      return _results;
    };
    Board.prototype.initialize_pawns = function(color) {
      var color_name, i, _i, _ref, _results;
      _ref = [color, this.colors.indexOf(color)], color_name = _ref[0], color = _ref[1];
      _results = [];
      for (i = _i = 0; _i <= 7; i = ++_i) {
        _results.push(new Pawn({
          color: color_name,
          board: this,
          position: [8 * color + i, 1]
        }));
      }
      return _results;
    };
    Board.prototype.has_piece_at = function(x, y) {
      return this.board[(24 + x) % 24][y] !== null;
    };
    Board.prototype.piece_at = function(x, y) {
      return this.board[(24 + x) % 24][y];
    };
    Board.prototype.place_piece = function(piece, x, y) {
      if (!(piece instanceof Piece)) {
        throw "Must place a Piece";
      }
      return this.board[(24 + x) % 24][y] = piece;
    };
    return Board;
  })();
  module.exports = Board;
}).call(this);
return module.exports || exports;
})(__cs.r, {}, {});

//index.js
__cs.libs.cs168726db = (function(require, module, exports) {
(function() {
  var Bishop, Board, King, Knight, Pawn, Queen, Rook;
  King = require('./engine/pieces/king');
  Queen = require('./engine/pieces/queen');
  Rook = require('./engine/pieces/rook');
  Bishop = require('./engine/pieces/bishop');
  Knight = require('./engine/pieces/knight');
  Pawn = require('./engine/pieces/pawn');
  Board = require('./engine/board');
  module.exports = {
    King: King,
    Queen: Queen,
    Rook: Rook,
    Bishop: Bishop,
    Knight: Knight,
    Pawn: Pawn,
    Board: Board
  };
}).call(this);
return module.exports || exports;
})(__cs.r, {}, {});

window.ThreeChessEngine = __cs.libs.cs168726db

