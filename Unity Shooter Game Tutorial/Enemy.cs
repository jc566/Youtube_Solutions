using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy : MonoBehaviour {

	public Rigidbody2D enemy; //reference to itself

	public float moveSpeed = 15.0f; //default move speed of the enemy

	public bool changeDirection = false; //by default set the bool to false

	// Use this for initialization
	void Start () {
		enemy = this.gameObject.GetComponent<Rigidbody2D>(); //make the connection to the reference
	}
	
	// Update is called once per frame
	void Update () {
		moveEnemy ();
	}

	public void moveEnemy()
	{
		
		if (changeDirection == true) {
			enemy.velocity = new Vector2 (1, 0) * -1 * moveSpeed; //get the enemy to move left
		} 
		else if (changeDirection == false) 
		{
			enemy.velocity = new Vector2 (1, 0) * moveSpeed; //get the enemy to move right
		}
	}


	void OnCollisionEnter2D(Collision2D col)
	{
		if (col.gameObject.name == "RightWall") 
		{
			Debug.Log ("Hit the right wall");
			changeDirection = true;
		}
		if (col.gameObject.name == "LeftWall") 
		{
			Debug.Log ("Hit the left wall");
			changeDirection = false;
		}
	}
}
