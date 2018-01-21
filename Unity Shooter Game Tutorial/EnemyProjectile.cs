using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyProjectile : MonoBehaviour {

	public Rigidbody2D projectile;

	public float moveSpeed = 15.0f;

	// Use this for initialization
	void Start () {
		projectile = this.gameObject.GetComponent<Rigidbody2D> ();
	}
	
	// Update is called once per frame
	void Update () {
		projectile.velocity = new Vector2 (0, -1) * moveSpeed;
	}

	//hit detection 
	void OnCollisionEnter2D(Collision2D col)
	{
		//when it hits the player
		if (col.gameObject.tag == "Player") 
		{
			col.gameObject.SetActive (false);
		}
		//when it hits the bottom of the screen
		if (col.gameObject.name == "Bottom") 
		{
			DestroyObject (this.gameObject);
		}
	}
}
