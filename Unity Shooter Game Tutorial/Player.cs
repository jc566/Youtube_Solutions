//link to youtube video https://www.youtube.com/watch?v=-on5HRW8v1A
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour {
	//controls how fast the player moves
	public float moveSpeed = 10.0f; //default speed, can change if you want.

	public Rigidbody2D player;

	// Use this for initialization
	void Start () {
		player = this.GetComponent<Rigidbody2D>();
	}
	
	// Update is called once per frame
	void FixedUpdate () {
		//this.transform.Translate(Input.GetAxis("Horizontal"),0,0); //using transform ignores physics!!!

		MovePlayer();
	
	}
	//this function allows for the player to move
	public void MovePlayer()
	{
		//movement through physics. Makes things like hitting walls much easier to deal with!
		player.velocity = new Vector2 (Input.GetAxis ("Horizontal"), Input.GetAxis("Vertical")) * moveSpeed;

	}
}
