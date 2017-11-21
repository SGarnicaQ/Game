class Room {
	int x, y;															/*Position of each room*/
	boolean[] walls = new boolean[4];									/*Rooms walls*/
	boolean visited, current, wroom;									/*state of the room {wroom = if is just a space or with Room..}*/
	Room[] ne = new Room[4];											/*neightbours rooms walls*/
	void initWalls(Room[][] room, int mSize) {
		if (y-1 >= 0)
			this.ne[0] = room[x][y-1];
		if (x+1 < mSize)
			this.ne[1] = room[x+1][y];
		if (y+1 < mSize)
			this.ne[2] = room[x][y+1];
		if (x-1 >= 0)
			this.ne[3] = room[x-1][y];
	}
	void createDungeon(ArrayList<Room> vis) {
		if (current)this.visited = true;
		if (current)select(vis);
	}
	void saveDungeon(JSONObject map){
		if (wroom){
			if (!walls[0])
				map.setFloat(x+"-"+y+"tup",0);
			if (!walls[1])
				map.setFloat(x+"-"+y+"tright",0);
			if (!walls[2])
				map.setFloat(x+"-"+y+"tdown",0);
			if (!walls[3])
				map.setFloat(x+"-"+y+"tleft",0);
		}else {
			if (!walls[0])
				map.setFloat(x+"-"+y+"fup",0);
			if (!walls[1])
				map.setFloat(x+"-"+y+"fright",0);
			if (!walls[2])
				map.setFloat(x+"-"+y+"fdown",0);
			if (!walls[3])
				map.setFloat(x+"-"+y+"fleft",0);
		}
	}
	void select(ArrayList<Room> vis) {
		int dir = (int)random(0, 4);
		if (ne[dir] != null) {
			if (!ne[0].visited || !ne[1].visited || !ne[2].visited || !ne[3].visited) {
				if (!ne[dir].visited) {
					ne[dir].current = true;
					this.current = false;
					vis.add(this);
					if (dir == 0) {
						this.walls[0] = false;
						ne[dir].walls[2] = false;
					}
					if (dir == 1) {
						this.walls[1] = false;
						ne[dir].walls[3] = false;
					}
					if (dir == 2) {
						this.walls[2] = false;
						ne[dir].walls[0] = false;
					}
					if (dir == 3) {
						this.walls[3] = false;
						ne[dir].walls[1] = false;
					}
				}
			} else {
				this.current = false;
				if (vis.size()>0) {
					vis.get(vis.size()-1).current = true;
					vis.remove(vis.size()-1);
				}
			}
		}
	}
	Room(int x, int y) {
		this.x = x;
		this.y = y;
		for (int i = 0; i<4; i++) {
			this.walls[i] = true;
			this.ne[i] = this;
		}
		this.wroom = chance(30);
	}
}