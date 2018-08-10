//link to youtube video https://www.youtube.com/watch?v=-on5HRW8v1A
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveProjectile : MonoBehaviour {

	public Rigidbody2D projectile;//reference to a rigidbody2d

	public float moveSpeed = 10.0f;

	// Use this for initialization
	void Start () {
		projectile = this.gameObject.GetComponent<Rigidbody2D> ();
	}
	
	// Update is called once per frame
	void Update () {
		projectile.velocity = new Vector2 (0, 1) * moveSpeed;
	}

	//add some hit detecion
	void OnCollisionEnter2D(Collision2D col)
	{
		//when it hits an enemy...
		if (col.gameObject.name == "Enemy") 
		{
			col.gameObject.SetActive (false);
		}
		//when it hits the top of the screen
		if (col.gameObject.name == "Top") 
		{
			DestroyObject (this.gameObject);
		}
	}
}
