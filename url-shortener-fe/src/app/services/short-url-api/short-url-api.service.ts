import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { retry } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root',
})
export class ShortUrlApiService {
  readonly BASE_URL = environment.api_base_path;

  constructor(private http: HttpClient) {}

  createShortUrl(originalUrl: string) {
    return this.http
      .post(`${this.BASE_URL}/short_urls`, { original_url: originalUrl })
      .pipe(retry(1));
  }
}
