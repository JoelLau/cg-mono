import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { retry } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ShortUrlApiService {
  constructor(private http: HttpClient) { }

  createShortUrl(originalUrl: string) {
    return this.http.post('/api/v1/short_urls', { original_url: originalUrl }).pipe(retry(1))
  }
}

